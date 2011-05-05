From: ccross@google.com (Colin Cross)
Date: Thu, 5 May 2011 11:21:21 -0700
Subject: Tegra gpio driver: Need to configure pins in gpio
	mode/nontristate with gpio-request
In-Reply-To: <96C9D994977DD0439FB6D3FE3B13DD906B1331B0BD@BGMAIL01.nvidia.com>
References: <96C9D994977DD0439FB6D3FE3B13DD906B1331B068@BGMAIL01.nvidia.com>
	<BANLkTikFgc2Oe5BrOpzYkjs7wnMdfNY4_w@mail.gmail.com>
	<96C9D994977DD0439FB6D3FE3B13DD906B1331B0BD@BGMAIL01.nvidia.com>
Message-ID: <BANLkTin1Q4+WBRvsJ1bs_zx8fuExBaLw4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 5, 2011 at 11:18 AM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> Then from user space using /sys/class/gpio sysfs interface, I can not make the pin to be
> gpio until I change the kernel code?

Yes, but that's normal.  We don't generally allow userspace to
override the kernel on things that could easily damage the board if it
does something wrong.
