From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 Oct 2013 17:51:13 +0100
Subject: [PATCHv4] video: backlight: gpio-backlight: Add DT support.
In-Reply-To: <20131022200141.GA8037@mithrandir>
References: <20131019104555.GI18477@ns203013.ovh.net>
 <1382346813-8449-1-git-send-email-denis@eukrea.com>
 <20131022045833.GB17512@ns203013.ovh.net>
 <20131022072307.GA8681@ulmo.nvidia.com>
 <20131022153445.GD17512@ns203013.ovh.net> <20131022200141.GA8037@mithrandir>
Message-ID: <5267FE81.3070201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2013 09:01 PM, Thierry Reding wrote:
> On Tue, Oct 22, 2013 at 05:34:45PM +0200, Jean-Christophe
> PLAGNIOL-VILLARD wrote:
...
>> I'm sorry but the blacklight descibe in DT have nothing to do
>> with the common pratice that the current driver have today
> 
> That's not at all what I said. What I said was that the majority
> of backlight drivers currently default to turning the backlight on
> when probed. Therefore I think it would be consistent if this
> driver did the same.
> 
> I also said that I don't think it's a very good default, but at the
> same time we can't just go and change the default behaviour at will
> because people may rely on it.

It may well be reasonable to change the default behaviour for devices
instantiated from DT. If it's not possible to instantiate the device
from DT yet, then it's not possible for anyone to be relying on the
default behaviour yet, since there is none. So, perhaps the default
could be:

* If device instantiated from a board file, default to on, for
backwards-compatibility.

* If device instantiated from DT, there is no backwards compatibility
to be concerned with, since this is a new feature, hence default to
off, since we think that's the correct thing to do.
