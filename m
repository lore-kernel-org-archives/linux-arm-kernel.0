From: david@lechnology.com (David Lechner)
Date: Wed, 12 Oct 2016 18:31:18 -0500
Subject: [PATCH/RFT 07/12] USB: ohci-da8xx: Request gpios and handle
 interrupt in the driver
In-Reply-To: <CAKXjFTMO_tCzLxc5wznrW_g6rxMYT8jBgHCtiFfpHq_6M=RZWA@mail.gmail.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
 <1475858577-10366-8-git-send-email-ahaslam@baylibre.com>
 <22f1532a-b651-3330-b2ce-9a64a35c85af@lechnology.com>
 <CAKXjFTMO_tCzLxc5wznrW_g6rxMYT8jBgHCtiFfpHq_6M=RZWA@mail.gmail.com>
Message-ID: <ca0cd34a-c904-e3b8-b9a9-55017265dc89@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2016 10:01 AM, Axel Haslam wrote:
> I  agree that we should use a regulator for the vbus power.
> i will make that change.  However, im not so sure about using the
> regulator for the overcurrent handling. There seems to be no other
> driver doing this, and as you mention, we would need to change the regulator
> framework, which might not be justifiable. I think there is not another way
> to handle the over current notification other than powering the port off.

The regulator framework has REGULATOR_EVENT_OVER_CURRENT already. 
Perhaps this could be of some use? For example you could extend the 
existing gpio-regulator driver with an optional overcurrent gpio pin.


>
> how about using regulator for vbus, but keeping gpio for overcurrent
> notifications?

See the suggestion above about extending the gpio-regulator driver.


> For the usersapce handling you describe above, maybe we should be able to
> listen for an usb overcurrent uevent in userspace? it seems this
> question was asked
> a couple of years back[1], but im not sure what the conclusion was. In any case,
> we could have DT and non-DT based ohci-da8xx working,
> And could work on a uevent notification for the scenario you describe
> above which
> i think is not specific to the ohci-da8xx.
>
> [1]http://linux-usb.vger.kernel.narkive.com/SjcUB5hk/how-best-to-get-over-current-notification-to-user-application

Thanks for the link. Too bad it seems nothing ever became of this. I 
guess it will be up to me to bring up the discussion again if I really 
want it.
