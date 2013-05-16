From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 16 May 2013 12:17:37 -0600
Subject: Naming convention DSI + device tree
In-Reply-To: <20130516071537.GA13573@mail.o2s.ch>
References: <20130514181745.GA2762@mail.o2s.ch>
 <51940C22.4050802@wwwdotorg.org> <20130516071537.GA13573@mail.o2s.ch>
Message-ID: <519522C1.5010107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 01:15 AM, David Lanzend?rfer wrote:
> On Wed, May 15, 2013 at 04:28:50PM -0600, Stephen Warren wrote:
>> On 05/14/2013 12:17 PM, David Lanzend?rfer wrote:
>>> Hello I have the following issue: In order to make the DSI
>>> controller react at all,
>> 
>> Hmm. In the upstream kernel, we don't even have a DSI driver at
>> all for Tegra, so control over the panel itself is likely the
>> least of your worries for now.
> 
> Is there a patch set pending for merge into upstream which will
> provide this support? And if yes, where can I find these pending
> patches? I'd like to build up my code based on already existing
> work which is expected to be in upstream at some later point of
> time.

No, we haven't yet posted DSI support upstream.

>>> I need to pass him a certain combination of pin states. Until
>>> now within the code of the original android kernel which was
>>> using board files this has just been done by doing bit
>>> banging.
>>> 
>>> namely: gpio_set_value(tf201_lvds_shutdown, 1); ... Now with a
>>> device tree comes the question: Where should I put this?
>> 
>> Likely, you will need to create a DT binding that represents the 
>> particular panel model that you have, and make the Tegra display 
>> controller node refer to that panel node. The panel node would
>> need properties to describe the various GPIOs used to control the
>> panel. Then, you'd want to write a panel-specific driver that
>> handles that device tree node.
> 
> That was my thought too. Where should I put this panel-specific
> driver?

Honestly, I'm not sure. I assume (and it is just an assumption) that
if you look at the CDF patches, you should find some examples of panel
drivers that use it, although perhaps there aren't any yet...

>> All of this will likely need to be integrated with the upcoming
>> Common Display Framework.
> 
> Is this upcoming CDF included within your "linux-next_common"
> branch?

No. That branch of mine is basd on linux-next, so whatever is in
linux-next is in my branch, and I certainly haven't applied the CDF
locally.

I believe the CDF has been posted to various mailing lists a few
times, but it isn't checked in yet since there isn't a final version.
I CC'd Alex; he might know the status better than me.
