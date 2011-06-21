From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 21 Jun 2011 16:33:57 -0600
Subject: [PATCH 1/3] serial/imx: add device tree support
In-Reply-To: <4E011678.4030208@firmworks.com>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<1308410354-21387-2-git-send-email-shawn.guo@linaro.org>
	<20110618161934.GH8195@ponder.secretlab.ca>
	<20110619073000.GA23171@S2100-06.ap.freescale.net>
	<20110621135558.GB9228@S2101-09.ap.freescale.net>
	<BANLkTim4vunTm1176MRw3pqRZnunu4=9jg@mail.gmail.com>
	<4E00F290.2010303@firmworks.com>
	<BANLkTik9LXTJ--fRwUBscokWraPwOZnpHA@mail.gmail.com>
	<4E011678.4030208@firmworks.com>
Message-ID: <BANLkTikBUo3jO=R0amkdxU1V3QMJoOUkEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 4:08 PM, Mitch Bradley <wmb@firmworks.com> wrote:
> On 6/21/2011 9:38 AM, Grant Likely wrote:
>>
>> On Tue, Jun 21, 2011 at 1:35 PM, Mitch Bradley<wmb@firmworks.com> ?wrote:
>>>
>>> What is the problem with
>>>
>>> aliases{
>>> ? serial0 = "/uart at 7000c000";
>>> }
>>>
>>> Properties in the alias node are supposed to have string values.
>>
>> ?
>>
>> Not sure I follow. ?Indeed, properties in the aliases node are string
>> values.
>>
>> Are you referring to how I was proposing some dtc syntax for
>> generating the alias strings?
>
>
> The point is that if you refer to the node explicitly by its string name,
> the need for a label disappears and the problem of overriding a default
> alias disappears (assuming that a later redefinition of a property takes
> precedence over an earlier one, as is the OFW convention).

Ah, we're having an impedance mismatch.  I'm thinking specifically
about the device tree compiler and some syntactic sugar for using the
label definition to generate /also/ create alias properties. The
hairiness is related to that and the way that dtc is implemented, not
with the final aliases themselves.

g.
