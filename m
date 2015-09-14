From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 14 Sep 2015 18:18:12 +0100
Subject: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI sensors
In-Reply-To: <9hhk2rtdq1f.fsf@e105922-lin.cambridge.arm.com>
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
 <1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
 <20150914131448.GC7002@leverpostej>
 <9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
 <20150914134949.GE7002@leverpostej>
 <9hhk2rtdq1f.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <1442251092.2850.53.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-09-14 at 15:38 +0100, Punit Agrawal wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
> 
> >> >> +Sensor bindings for the sensors based on SCPI Message Protocol
> >> >> +--------------------------------------------------------------
> >> >> +SCPI provides an API to access the various sensors on the SoC.
> >> >> +
> >> >> +Required properties:
> >> >> +- compatible : should be "arm,scpi-sensors".
> >> >> +- #thermal-sensor-cells: should be set to 1. This property follows the
> >> >> +			 thermal device tree bindings[2].
> >> >
> >> > You need to specify what the valid values for this cell are.
> >> 
> >> The enumeration depends on the number of sensors exported by SCP
> >> firmware - which is platform dependent. I could add add something like
> >> if you think that is helpful -
> >> 
> >> "Valid cell value is a number between 0..n-1, where n is the number
> >> of sensors exported by SCP firmware."
> >
> > Can the FW identifer space have holes? Or are they always contiguous?
> 
> The way the SCP interface is defined, the sensor identifiers are
> contiguous,

Is there any documentation other than DUI0922A? [1] From what I can seen
that just says it's a 16-bit value and doesn't put any particular
constraints on its value.

[1] http://community.arm.com/servlet/JiveServlet/download/8401-40-18262/DUI0922A_scp_message_interface.pdf

-- 
Tixy
