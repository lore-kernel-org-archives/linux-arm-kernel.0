From: sdharia@codeaurora.org (Sagar Dharia)
Date: Mon, 4 Jun 2012 02:51:49 -0700 (PDT)
Subject: [PATCH] slimbus: Linux driver framework for SLIMbus.
In-Reply-To: <4FCC280C.6030103@landley.net>
References: <1338340310-4473-1-git-send-email-sdharia@codeaurora.org>
 <4FCC280C.6030103@landley.net>
Message-ID: <53f16b8f6198e1adb9cc54bb8b9d80cb.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Slim?
>
SLIMbus is MIPI alliance specification. Since word "bus" is part of the
specification, I thought it will be good to keep it that way.

The specification is available to all MIPI members.
Some more info here:
http://mipi.org/specifications/serial-low-power-inter-chip-media-bus-slimbussm-specification

>> +and the messages can be of unicast and broadcast type. E.g.
>> reading/writing
>> +device specific values is typically a unicast message. A data channel
>> +reconfiguration sequence is announced to all devices using a broadcast
>> message.
>
> Unicast messages are seen by all devices?
>
I was trying to give example of each type of both message. I will reword
it to be more clear.

>> +Slimbus specification has different types of device classifications
>> based on
>> +their capabilities.
>
> I'm trying to figure out if that sentence conveys any information at all.
>
I will reword this to say: "has following type of device classifications
based on capabilities:".

> So each slimbus has 1 manager device that enumerates configures, and
> allocates channels for the other devices on the bus. The rest are
> "framer" devices that transmit data packets?
>
Typically there is 1 framer per bus, but if there are multiple framers
then manager is responsible for doing handoff between framers.
>
> However, I expect some example code would be far more useful than this
> document...
>
Please refer to slimbus.c for slimbus framework.

Thank you for your comments. I will address all the comments in the next
patch.

Regards
Sagar

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
