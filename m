From: nm@ti.com (Nishanth Menon)
Date: Tue, 26 Nov 2013 09:49:27 -0600
Subject: Status of 1GHz support on am37xx
In-Reply-To: <20131125233545.GZ10023@atomide.com>
References: <20131122230121.GA13440@animalcreek.com>
 <20131125233545.GZ10023@atomide.com>
Message-ID: <5294C307.1080703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2013 05:35 PM, Tony Lindgren wrote:
> * Mark A. Greer <mgreer@animalcreek.com> [131122 15:02]:
>> Hello.
>>
>> I was wondering what that the status of 1GHz support for the am37xx is.
>>
>> It looks like smartreflex/avs and ABB drivers are there.  Do they need
>> more work (e.g., DT support)?  What DT nodes and related support need
>> to be added?
>>
>> What pieces are being worked on and which ones aren't?
>> Is there an ETA for the pieces being worked on?
> 
> There are still various parts of twl4030 that are only working with
> platform data, so at least those should be fixed now that we're moving
> to DT only based booting for mach-omap2 for v3.14.
> 

For 3630/DM3730 1GHz support the following needs to be done:
a) clock nodes[1] without which cpufreq-cpu0 will never scale frequencies
The following includes conversion to device tree enabled support.
b) VC-vp regulator
c) ABB dt nodes
d) AVS class 1.5 support
e) voltage regulator notifier around clock node for mpu so that avs
and abb can be sequenced around voltage and frequency changes.

So, to answer your question, we are a little farther away beyond the
first step of DT only boot to being able to exercise 1GHz properly.

[1] http://marc.info/?l=linux-omap&m=138545331825036&w=2
-- 
Regards,
Nishanth Menon
