From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 10 Oct 2016 19:46:10 +0530
Subject: [PATCH 1/2] host: ehci-exynos: Convert to use the
 SET_SYSTEM_SLEEP_PM_OPS
In-Reply-To: <Pine.LNX.4.44L0.1610091713490.1734-100000@netrider.rowland.org>
References: <20161009163446.GA9672@kozik-lap>
 <Pine.LNX.4.44L0.1610091713490.1734-100000@netrider.rowland.org>
Message-ID: <CANAwSgTfnjmyHJv+MTr1ukcwjb8cu73564kFqb2u=5xtX-r7Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Alan/Krzysztof,

On 10 October 2016 at 02:47, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sun, 9 Oct 2016, Krzysztof Kozlowski wrote:
>
>> On Sun, Oct 09, 2016 at 02:34:14PM +0000, Anand Moon wrote:
>> > Move the ehci-exynos system PM callbacks within #ifdef CONFIG_PM_SLEEP
>> > as to avoid them being build when not used. This also allows us to use the
>> > SET_SYSTEM_SLEEP_PM_OPS macro which simplifies the code.
>> >
>> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> > ---
>> >  drivers/usb/host/ehci-exynos.c | 14 ++++++--------
>> >  1 file changed, 6 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
>> > index 42e5b66..1899900 100644
>> > --- a/drivers/usb/host/ehci-exynos.c
>> > +++ b/drivers/usb/host/ehci-exynos.c
>> > @@ -251,7 +251,7 @@ static int exynos_ehci_remove(struct platform_device *pdev)
>> >     return 0;
>> >  }
>> >
>> > -#ifdef CONFIG_PM
>> > +#ifdef CONFIG_PM_SLEEP
>>
>> Does not look like an equivalent change. How will it behave in a config
>> with !SUSPEND && !HIBERNATE && PM?
>
> It's hard to say what Anand originally had in mind.  To me, it looks
> like it will behave exactly the same as before, the only difference
> being that the object image will not contain unused exynos_ehci_suspend
> and exynos_ehci_resume routines.  And the compiler won't issue a
> warning at build time that the routines are unused.
>
> Alan Stern
>

Thanks for looking into this closely.

I will just send one line changes to use SET_SYSTEM_SLEEP_PM_OPS
with better commit logs, if you people agree with this.

Best Regards
-Anand Moon
