From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 27 Dec 2011 17:26:00 +0000
Subject: [alsa-devel] [PATCH 2/4] ASoC: cx20442: add bias control over a
 platform provided regulator
In-Reply-To: <201112271516.09114.jkrzyszt@tis.icnet.pl>
References: <1324681944-19067-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <1324681944-19067-3-git-send-email-jkrzyszt@tis.icnet.pl>
 <20111226110201.GA8722@opensource.wolfsonmicro.com>
 <201112271516.09114.jkrzyszt@tis.icnet.pl>
Message-ID: <20111227172559.GB22970@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2011 at 03:16:08PM +0100, Janusz Krzysztofik wrote:
> On Monday 26 of December 2011 at 12:02:01, Mark Brown wrote:

> > which would look a lot more natural - you shouldn't need to remember if
> > the regulator is enabled, you should just turn it on in the STANDBY to
> > PREPARE transition and turn it off in the ON to PREPARE or PREPARE to
> > STANDBY transitions.

> Can I assume STANDBY or OFF at the time the codec .remove method is 
> called? If not, is there a helper function available which can be called 
> in order to perform all those ON -> PREPARE -> STANDBY [-> OFF] transitions before calling regulator_put()?

It'll be in STANDBY or OFF depending on if the device sets
idle_bias_off.
