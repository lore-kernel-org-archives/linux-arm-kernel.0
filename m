From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Sep 2015 11:56:43 +0200
Subject: [PATCH 2/2] arm64: to allow EFI_RTC can be selected on ARM64
In-Reply-To: <56090C08.8070003@huawei.com>
References: <1443418478-8240-1-git-send-email-thunder.leizhen@huawei.com>
 <2245172.1ESUGv0DKo@wuerfel> <56090C08.8070003@huawei.com>
Message-ID: <1493434.sLUZ1A9ljb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 September 2015 17:44:40 Leizhen wrote:
> >> No, on non-EFI platforms, they can still use RTC as before. As I mentioned above,
> >> RTC_LIB only controls whether to display some configs when run "make menuconfig".
> >> On ARM64, (in this patch) I only allowed EFI_RTC can be showed when RTC_LIB was
> >> not selected.
> >>
> > 
> > but that is the wrong driver that uses the legacy API, we cannot have that
> > on ARM because it conflicts with the normal RTC_CLASS drivers.
> 
> Yes, RTC_CLASS will automatically select RTC_LIB, and will not display EFI_RTC, because
> RTC_LIB=y now.
> 
> We can select EFI_RTC only when RTC_CLASS is not selected(meanwhile RTC_LIB=n)

I understood that, and my initial point was that we cannot allow
such a situation, all drivers that we might use must be able to coexist
in one kernel.

If you have any applications that are ported from Itanium and that rely on
specific behavior of the ia64 rtc driver, we should either enable those in the
normal rtc-efi driver, or you need to change your application to use the
portable RTC interfaces.

	Arnd
