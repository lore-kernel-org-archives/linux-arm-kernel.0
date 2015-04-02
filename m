From: lhikichi@broadcom.com (Lori Hikichi)
Date: Thu, 2 Apr 2015 11:47:07 -0700
Subject: [PATCH 1/2] ASoC: cygnus-audio: adding device tree bindings
In-Reply-To: <20150331055806.GB2869@sirena.org.uk>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
 <20150331055806.GB2869@sirena.org.uk>
Message-ID: <551D8EAB.3070803@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15-03-30 10:58 PM, Mark Brown wrote:
> On Mon, Mar 30, 2015 at 08:16:23PM -0700, Scott Branden wrote:
>
>> +SSP Subnode properties:
>> +- dai-name: The name of the DAI registered with ASOC
>
> ASoC.
>
Okay.

> Why is this in the DT - it sounds like this is just an internal
> implementation detail for Linux, not a property of the hardware.
>
Will move into the driver code.

>> +- mode: Controls if this port should be configured as I2S or TDM mode.
>> +	Valid values are: "tdm" or "i2s"
>> +- tdm-bits-per-frame:  only if mode is "tdm" then this property must set.
>> +	Valid values are (128/256/512)
>
> We'd normally leave these up to the machine driver to set as they're
> link wide things for system integration.  The bits per frame in
> particular looks like something that's not going to be fixed by the
> hardware and could be varied at runtime.
>
I was using the device tree to set some board specific properties of our 
audio serial port driver. The idea was that these properties would only 
need to be one value for a specific board.  Therefore, we could set them 
in the device tree and then not have to set them in the
machine file. I thought it would help keep the machine file
a little more basic.  Moving these to the machine file is reasonable and 
will allow for a more dynamic usage of our driver.  I will move them to 
machine file.

>> +- port-status: Controls if port is enabled or not
>> +	Valid values "enabled" or "disabled"
>
> This sounds like it's replicating the DT standard status property?
>
Okay. Will replace with "status"

>> +- channel-group: Control grouping of serial port
>> +	Valid values are "2_0", "3_1", or "5_1"
>
> What does this mean?  It looks like it's setting the number of channels
> which again seems like a runtime thing.
>
It is a configuration where we can link together two or three of the 
ports to allow for synchronized starts and stop. I will look into 
another method of configuring this operational mode.
