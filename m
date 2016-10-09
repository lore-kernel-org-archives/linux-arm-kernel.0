From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 9 Oct 2016 20:27:57 +0300
Subject: [PATCH 1/2] host: ehci-exynos: Convert to use the
 SET_SYSTEM_SLEEP_PM_OPS
In-Reply-To: <CANAwSgSr6-0x47=0P_NCiGCv=FSZR9dNT89JpY=9R_32U8HywQ@mail.gmail.com>
References: <1476023655-3232-1-git-send-email-linux.amoon@gmail.com>
 <20161009163446.GA9672@kozik-lap>
 <CANAwSgSr6-0x47=0P_NCiGCv=FSZR9dNT89JpY=9R_32U8HywQ@mail.gmail.com>
Message-ID: <20161009172757.GA11916@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 09, 2016 at 10:45:40PM +0530, Anand Moon wrote:
> Hi Krzysztof,
> 
> On 9 October 2016 at 22:04, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Sun, Oct 09, 2016 at 02:34:14PM +0000, Anand Moon wrote:
> >> Move the ehci-exynos system PM callbacks within #ifdef CONFIG_PM_SLEEP
> >> as to avoid them being build when not used. This also allows us to use the
> >> SET_SYSTEM_SLEEP_PM_OPS macro which simplifies the code.
> >>
> >> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >> ---
> >>  drivers/usb/host/ehci-exynos.c | 14 ++++++--------
> >>  1 file changed, 6 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
> >> index 42e5b66..1899900 100644
> >> --- a/drivers/usb/host/ehci-exynos.c
> >> +++ b/drivers/usb/host/ehci-exynos.c
> >> @@ -251,7 +251,7 @@ static int exynos_ehci_remove(struct platform_device *pdev)
> >>       return 0;
> >>  }
> >>
> >> -#ifdef CONFIG_PM
> >> +#ifdef CONFIG_PM_SLEEP
> >
> > Does not look like an equivalent change. How will it behave in a config
> > with !SUSPEND && !HIBERNATE && PM?
> >
> 
> [snip]
> 
> I just wanted to update suspend and resume callback to use
> SET_SYSTEM_SLEEP_PM_OPS
> as they are define under CONFIG_PM_SLEEP so I update above to avoid
> compilation warning/error.

First of all you did not answer to my question, so let me rephrase into
two:
1. Is the code equivalent?
2. What will be the output with !SUSPEND && !HIBERNATE && PM?

You didn't mention compilation warning/error in message commit so I do
not know what you are thinking about...

Best regards,
Krzysztof
