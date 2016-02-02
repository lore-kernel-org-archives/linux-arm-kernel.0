From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Tue, 2 Feb 2016 08:12:50 +0000
Subject: [PATCH 00/11] arm64: Introduce Allwinner A64 and Pine64 support
In-Reply-To: <b1250d48-a7a1-4f7f-893b-9abe3c91724e@googlegroups.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <b1250d48-a7a1-4f7f-893b-9abe3c91724e@googlegroups.com>
Message-ID: <56B06502.8030002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/16 07:57, lists.nick.betteridge at gmail.com wrote:
> Just a quick question - will there be any support for enabling booting into virtualisation mode to run xen and the like?

This is a firmware issue. The SoC itself provides everything you need
and even Allwinner choosing ARM Trusted Firmware (ATF) to do PSCI
handling shows how to do it - but for whatever reason they hacked it to
_not_ enter the kernel (or Xen, for that matter) in EL2.

But this should be fixable - either by using U-Boot's PSCI support or by
doing a proper ATF port. I am tempted to look at the latter.

Rest assured that using KVM was the primary reason I backed the Pine64,
so this definitely will be supported some day. Booting Xen does not make
much difference in this respect then.

Cheers,
Andre
