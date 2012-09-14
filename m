From: p.paneri@samsung.com (Praveen Paneri)
Date: Fri, 14 Sep 2012 15:29:14 +0530
Subject: [PATCH v5 1/5] usb: phy: samsung: Introducing usb phy driver for
 hsotg
In-Reply-To: <33690123.AyeJMS7yMW@flatron>
References: <1347446757-20519-1-git-send-email-p.paneri@samsung.com>
 <1347446757-20519-2-git-send-email-p.paneri@samsung.com>
 <50506D2A.7040908@pengutronix.de> <33690123.AyeJMS7yMW@flatron>
Message-ID: <CAD6zSYOjpfZX4w6-ZR24QDoga7bQq9bzC8Yie=xX2BZPK3ta3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 9:51 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Praveen, Marc,
>
> On Wednesday 12 of September 2012 13:08:26 Marc Kleine-Budde wrote:
>> > +static const struct of_device_id samsung_usbphy_dt_match[];
>> > +
>> > +static inline int samsung_usbphy_get_driver_data(struct
>> > platform_device *pdev) +{
>> > +#ifdef CONFIG_OF
>>
>> if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
>
> Is this check needed at all?
>
> In case of CONFIG_OF disabled, of_node should always be NULL and there is a
but I guess it can also be NULL when CONFIG_OF is enabled but the
driver is probed non DT way.
> dummy macro provided for of_match_node, so it should compile and work just
> fine.
>
> --
> Best regards,
> Tomasz Figa
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
