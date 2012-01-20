From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 20 Jan 2012 11:36:07 +0100
Subject: mc13xxx: add I2C support
In-Reply-To: <201201201855.35971.marc@cpdesign.com.au> (Marc Reilly's message
 of "Fri, 20 Jan 2012 18:55:35 +1100")
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
 <87lip4kktc.fsf@lebrac.rtp-net.org>
 <20120119112941.GC29494@sirena.org.uk>
 <201201201855.35971.marc@cpdesign.com.au>
Message-ID: <878vl2lkyw.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Reilly <marc@cpdesign.com.au> writes:

> Hi,

Hi,

>
> Thankyou all for your feedback and comments. I'll use them for a V2 but 
> Samuel, I'd like to know if you'd like me to base them on a specific branch 
> before I do.
>
> Shawn, thanks for testing!
>
> On Thursday, January 19, 2012 10:29:41 PM Mark Brown wrote:
>> On Thu, Jan 19, 2012 at 12:12:31PM +0100, Arnaud Patard wrote:
>> > I've never looked at regmap deeply but can't it be done with regmap or is
>> > it just a bad idea ?
>> 
>> Glancing quickly at the existing code it should map on reasonably well,
>> though a new format definition may be required for the 25 bit shift that
>> would be trivial.
>
> I'm sadly unfamiliar with regmap, is it a far superior solution? does it need 

The aim of regmap is to provide a solution for chip running either on
i2c or spi, that's why I thought it would be interesting to use it
instead of rewriting similar code.

> to used now? (ie. I'm relucant to totally rework this now. Please convince me 
> I need to if required.)

I don't know. I've no strong opinion about it. Moreover, nothing
prevents you to try to merge this version and then convert to regmap,
say once the 25 bit shift problem noticed by Mark is fixed.

Arnaud
