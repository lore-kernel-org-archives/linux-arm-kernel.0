From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 May 2016 14:11:15 +0200
Subject: [PATCH] reset: Put back *_optional variants
In-Reply-To: <5cf9f346-9b6e-d521-612c-9edd167aa759@redhat.com>
References: <ca359e013c30f27c825a9580164b01da5ca6476d.1464224883.git.johnyoun@synopsys.com>
 <12e450f0-70ea-29f8-0bf7-8a0697263f2d@redhat.com>
 <57476E48.2060204@synopsys.com>
 <dcf6372f-4910-bd03-f1b5-c7e0086fdead@redhat.com>
 <1464603520.3808.34.camel@pengutronix.de>
 <5cf9f346-9b6e-d521-612c-9edd167aa759@redhat.com>
Message-ID: <1464610275.3808.36.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 30.05.2016, 13:32 +0200 schrieb Hans de Goede:
> Hi,
> 
> On 30-05-16 12:18, Philipp Zabel wrote:
> > Hi,
> >
> > Am Freitag, den 27.05.2016, 09:06 +0200 schrieb Hans de Goede:
> > [...]
> >>>> So IMHO the following change would be a better way to fix this:
> >>>>
> >>>> --- a/include/linux/reset.h
> >>>> +++ b/include/linux/reset.h
> >>>> @@ -65,14 +65,14 @@ static inline struct reset_control *__of_reset_control_get(
> >>>>                                          struct device_node *node,
> >>>>                                          const char *id, int index, int shared)
> >>>>   {
> >>>> -   return ERR_PTR(-EINVAL);
> >>>> + return ERR_PTR(-ENOTSUPP);
> >>>>   }
> >>>>
> >>>>   static inline struct reset_control *__devm_reset_control_get(
> >>>>                                          struct device *dev,
> >>>>                                          const char *id, int index, int shared)
> >>>>   {
> >>>> -   return ERR_PTR(-EINVAL);
> >>>> + return ERR_PTR(-ENOTSUPP);
> >>>>   }
> >>>>
> >>>>   #endif /* CONFIG_RESET_CONTROLLER */
> >>>
> >>>
> >>> I'm good with this. However, per Philipp on a previous thread, the
> >>> intended behavior is to return -EINVAL for the non-optional functions.
> >>>
> >>> http://marc.info/?l=linux-usb&m=146156945528848&w=2
> >
> > Adding Dinh to Cc: because he wanted this changed from -EINVAL.
> > My point then was that WARN_ON + -EINVAL is indented in this case.

No idea how this happened, but I meant "intended", obviously :)

regards
Philipp
