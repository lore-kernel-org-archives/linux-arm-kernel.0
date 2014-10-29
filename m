From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 29 Oct 2014 11:18:54 +0100
Subject: [PATCH v5 3/4] regulator: max77686: Add suspend disable for some
 LDOs
In-Reply-To: <20141029100142.GR18557@sirena.org.uk>
References: <1414411911-5539-1-git-send-email-k.kozlowski@samsung.com>
 <1414411911-5539-4-git-send-email-k.kozlowski@samsung.com>
 <20141028223121.GH18557@sirena.org.uk> <1414574413.18868.6.camel@AMDC1943>
 <20141029100142.GR18557@sirena.org.uk>
Message-ID: <1414577934.18868.7.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2014-10-29 at 10:01 +0000, Mark Brown wrote:
> On Wed, Oct 29, 2014 at 10:20:13AM +0100, Krzysztof Kozlowski wrote:
> > On wto, 2014-10-28 at 22:31 +0000, Mark Brown wrote:
> 
> > > This looks wrong, you're using the regular enable operation as suspend
> > > enable.  How does that work without disrupting the current runtime
> > > state?
> 
> > Currently it shouldn't disrupt state of regulator because during runtime
> > it may only be only: on (0x3) or off (0x0). Suspend enable in max77686
> > writes 0x3 to the register which means - always on.
> 
> > If regulator was disabled before suspend then it has to be enabled
> > during suspend_enable() call which is exactly what max77686_enable does.
> > If it was enabled then nothing happens.
> 
> No, this isn't suspend enable control - this is normal, standard enable
> control and the device has no suspend enable control.

You mean that for such regulator the driver shouldn't implement
suspend_enable()?

Best regards,
Krzysztof
