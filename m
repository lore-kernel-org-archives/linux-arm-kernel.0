From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 11:15:10 +0000
Subject: [PATCH 14/17] ASoC: Implement "auto nc pins" feature
In-Reply-To: <1322011285-4002-15-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-15-git-send-email-swarren@nvidia.com>
Message-ID: <20111123111510.GH21073@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 06:21:22PM -0700, Stephen Warren wrote:
> Codecs often have a large number of external pins, and not all of these pins
> will be connected on all board designs. Some machine drivers therefore call
> snd_soc_dapm_nc_pin() for all the unused pins, in order to tell the ASoC core
> never to activate them.

This looks good from a code point of view but can you please rename the
flag that needs to be set to something like "fully_routed" so that if we
think of anything else we can do with a fully specified card routing map
then the flag name doesn't look wrong.
