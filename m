From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 1 Jul 2016 14:11:12 +0900
Subject: [RFC] arm64: kexec_file_load support
Message-ID: <20160701051111.GL20774@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm not sure whether there is any demand for kexec_file_load
support on arm64, but anyhow I'm working on this and now
my early prototype code does work fine.

There is, however, one essential issue:
While arm64 kernel requires a device tree blob to be set up
correctly at boot time, the current system call API doesn't
have this parameter.
    int kexec_file_load(int kernel_fd, int initrd_fd,
                        unsigned long cmdline_len, const char *cmdline_ptr,
                        unsigned long flags);

Should we invent a new system call, like kexec_file_load2,
and, if so, what kind of interface would be desired?

Thanks,
-Takahiro AKASHI
