From: stigge@antcom.de (Roland Stigge)
Date: Fri, 18 May 2012 10:03:22 +0200
Subject: [PATCH RESEND v9 1/2] gpio: Adjust of_xlate API to support
 multiple GPIO chips
In-Reply-To: <20120517203706.6B8223E0621@localhost>
References: <1337200832-26630-1-git-send-email-stigge@antcom.de>
 <20120517203706.6B8223E0621@localhost>
Message-ID: <4FB6024A.5010002@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 05/17/2012 10:37 PM, Grant Likely wrote:
> On Wed, 16 May 2012 22:40:31 +0200, Roland Stigge <stigge@antcom.de> wrote:
>> This patch changes the of_xlate API to make it possible to manipulate the
>> actual used gc. This way, multiple GPIO banks can be supported with the same DT
>> registered GPIO controller.
>>
>> The issue was discussed upon the integration of LPC32xx's DT support for its
>> GPIO (see separate patch).
>>
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> I still wasn't happy with this approach, so I bugged Arnd and we
> discussed some options.  So, I think I've got a better solution that
> doesn't change the signature of of_xlate.  Instead it allows of_xlate
> to return an error code and still have multiple banks referring to the
> same gpio_chip.
> 
> I've just posted the series.  Can you try it out and make sure it
> works for you?

Works fine, just consider the little compile error bugfix, see next mail.

Thanks,

Roland
