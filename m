From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 18 Mar 2014 10:52:59 +0200
Subject: [PATCHv2 2/8] Doc/DT: Add DT binding documentation for Analog
 TV Connector
In-Reply-To: <CAMuHMdVhh_qqXvUP9zUo0iCJ=O6bLqp-qTdaMQNLNcVgAgROBg@mail.gmail.com>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>	<1395130547-18633-3-git-send-email-tomi.valkeinen@ti.com>
 <CAMuHMdVhh_qqXvUP9zUo0iCJ=O6bLqp-qTdaMQNLNcVgAgROBg@mail.gmail.com>
Message-ID: <5328096B.5080206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/14 10:40, Geert Uytterhoeven wrote:
> Hi Tomi,
> 
> On Tue, Mar 18, 2014 at 9:15 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/video/analog-tv-connector.txt
>> @@ -0,0 +1,25 @@
>> +Analog TV Connector
>> +===================
>> +
>> +Required properties:
>> +- compatible: "composite-connector" or "svideo-connector"
>> +
>> +Optional properties:
>> +- label: a symbolic name for the connector
>> +
>> +Required nodes:
>> +- Video port for TV input
> 
> Only input, not output?

Yes, I have only made the bindings for display. I have no experience on
the capture side. I can change the port bindings for the connectors to
say they may be input or output, but I have to say I have no idea
whether the bindings work for capture.

But this is also something that I think could be extended in the future,
when we have some code to actually use them on capture pipeline. For now
it may be safer to keep them only for display.

> Have you considered adding bindings for other analog connector types?
>   - composite (YCbCr),
>   - component with and without sync-on-green (RGB and RGBHV),
>   - D-terminal (D1/D2/D3/D4/D5).
> 
> Am I missing some?

No, I haven't. I have no experience on those, and generally very little
experience on analog video. I've added bindings only for the hardware I
have.

If there are lots of different analog TV connectors, should I just split
the current "analog-tv-connector" into separate composite and svideo,
instead of trying to manage them with a single one? The reason I
combined composite and svideo was that there didn't seem anything else
to specify than the connector type.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/0fe5f211/attachment.sig>
