From: geoff@infradead.org (Geoff Levand)
Date: Fri, 15 Mar 2013 17:24:26 -0700
Subject: [PATCH 23/29] arm64: KVM: 32bit GP register access
In-Reply-To: <1362455265-24165-24-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-24-git-send-email-marc.zyngier@arm.com>
Message-ID: <1363393466.3155.77.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, 2013-03-05 at 03:47 +0000, Marc Zyngier wrote:
> diff --git a/arch/arm64/kvm/regmap.c b/arch/arm64/kvm/regmap.c
> new file mode 100644
> index 0000000..f8d4a0c
> --- /dev/null
> +++ b/arch/arm64/kvm/regmap.c

...

> +	switch (mode) {
> +	case COMPAT_PSR_MODE_USR...COMPAT_PSR_MODE_SVC:

I think it would be safer to have this with spaces in case someone
changes the macro defs or copies this to make some new code and screws
up their defs:

  case COMPAT_PSR_MODE_USR ... COMPAT_PSR_MODE_SVC:

See: http://gcc.gnu.org/onlinedocs/gcc-4.1.2/gcc/Case-Ranges.html

-Geoff
