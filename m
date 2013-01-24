From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Thu, 24 Jan 2013 12:17:03 +0100
Subject: Soc MC13783: Improve driver to handle LineIn
In-Reply-To: <510101FE.4060307@gmail.com>
References: <510101FE.4060307@gmail.com>
Message-ID: <5101182F.1090404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 01/24/2013 10:42 AM, Ga?tan Carlier wrote:
> Hello,
> I would like to improve MC13783 driver to be able to control bypass of
> LineIn (RXINR/L) and feed Analog LineIn stream into ouput Mixer via
> ADDRXIN flag.
By cleaning-up/rewriting my code, I get the bypass working.
Now I will try to put a mixer widget referenced "Mixer, Adder, Balance" 
in "Audio Ouput Section Diagram" of User's guide to be able to select 
which analog audio stream will be fed into selector then I will add 
control to be able to select needed SOC_DAPM_OUTPUT.

Is there a way to defined state of a SND_SOC_DAPM_SWITCH to 1 or 0 by 
default ?

> This first step one is for test purpose but I also need to select
> RXINR/L as capture source (I saw in RM that CODEC must be enabled and
> only RXINR flag must be selected as input) but nothing seems to be
> captured this is why I need bypass working to test input level, and so on.
>
> I try to create a Mixer based on other driver but it doesn't work.
> I try to finc information about widget macro SND_SOC_DAPM_* but it is
> hard to find something relevant.
> * Which widgets can be link together ?
> * Is there functional difference between VIRT and non-VIRT widget ?
>
> I will post my code in some minutes after clean-up.
>
> Thanks a lot.
> Ga?tan Carlier.
Thanks,
Ga?tan Carlier.
