From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 26 Apr 2016 10:20:51 +0100
Subject: [PATCH] arm64: fix /proc/cpuinfo for elf32
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED0A6E6FB7@SZXEMA509-MBX.china.huawei.com>
References: <1461555453-60440-1-git-send-email-prime.zeng@huawei.com>
 <20160425091239.GB9614@e104818-lin.cambridge.arm.com>
 <678F3D1BB717D949B966B68EAEB446ED0A6E6FB7@SZXEMA509-MBX.china.huawei.com>
Message-ID: <571F32F3.7080005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/16 03:21, Zengtao (B) wrote:
>
> So you mean the 64-bit grep should see the same cpuinfo as its father process
> which is 32-bit?
>
> For 32-bit process running on 64-bit kernel, we have to explicitly call the personality
> syscall to get the right cpuinfo, but how to deal with the old 32-bit binaries?

Yes, you could use the syscall to switch the personality. Alternately, you could run
"linux32" command to switch the personality to PER_LINUX32 and then execute
64/32 bit applications.

Suzuki
