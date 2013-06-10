From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 10 Jun 2013 23:56:16 +0200
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130610214842.GB18614@n2100.arm.linux.org.uk>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk> <51B5B41A.7070306@gmail.com>
 <20130610214842.GB18614@n2100.arm.linux.org.uk>
Message-ID: <51B64B80.5060709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2013 11:48 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 10, 2013 at 01:10:18PM +0200, Sebastian Hesselbarth wrote:
>> On 06/09/13 21:29, Russell King wrote:
>>> +static const struct armada_output_type armada_drm_conn_slave = {
>>> +	.connector_type	= DRM_MODE_CONNECTOR_HDMIA,
>>
>> For a rework of DRM slave encoder API, there should also be some way to
>> get .connector_type and .encoder_type above from that slave encoder.
>> IMHO it should be up to the slave encoder to determine connector and
>> encoder type.
>
> Encoder type - yes, but connector type doesn't seem sensible.  It's
> possible for the TDA998x to be connected to a DVI connector - how
> would the slave encoder know that?

True. But how should Armada DRM driver know? Actually, it is not
important where we put that information. IMHO it is more likely
to be known by TDA998x as by the corresponding master encoder.
With DT I'd suggest to have a property for TDA998x that sets either
HDMI A/B/C or DVI.

Not related to CuBox setup, but with DisplayPort it can even get worse,
e.g. consider a dumb LCDC connected to some DP++ (HDMI protocol over DP
electrical) encoder connected to a TMDS level shifter. Where do you put
the (final) connector type if not in the last encoder connected to that
chain?

Sebastian
