From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 14 Sep 2015 15:38:36 +0100
Subject: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI sensors
In-Reply-To: <20150914134949.GE7002@leverpostej> (Mark Rutland's message of
 "Mon, 14 Sep 2015 14:49:49 +0100")
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
 <1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
 <20150914131448.GC7002@leverpostej>
 <9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
 <20150914134949.GE7002@leverpostej>
Message-ID: <9hhk2rtdq1f.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland <mark.rutland@arm.com> writes:

>> >> +Sensor bindings for the sensors based on SCPI Message Protocol
>> >> +--------------------------------------------------------------
>> >> +SCPI provides an API to access the various sensors on the SoC.
>> >> +
>> >> +Required properties:
>> >> +- compatible : should be "arm,scpi-sensors".
>> >> +- #thermal-sensor-cells: should be set to 1. This property follows the
>> >> +			 thermal device tree bindings[2].
>> >
>> > You need to specify what the valid values for this cell are.
>> 
>> The enumeration depends on the number of sensors exported by SCP
>> firmware - which is platform dependent. I could add add something like
>> if you think that is helpful -
>> 
>> "Valid cell value is a number between 0..n-1, where n is the number
>> of sensors exported by SCP firmware."
>
> Can the FW identifer space have holes? Or are they always contiguous?

The way the SCP interface is defined, the sensor identifiers are
contiguous, but not all are temperature sensors.

>
> If this is the same as the raw FW identifer value, specify that.
> Otherwise, you need to specify the mapping.

I'll update the patch to add mappings for Juno r0 (and r1 if I can get
my hands on one).

>
> There needs to be enough information for a dts author to figure out
> which values to place in the DT.

I understand. Except sometimes it is hard to get the firmware to commit to not
modify the ordering - discoverability and all that. :)

>
> Thanks,
> Mark.
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
