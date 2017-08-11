From: jeffy.chen@rock-chips.com (jeffy)
Date: Fri, 11 Aug 2017 09:30:21 +0800
Subject: [PATCH v2 3/3] dt-bindings: ASoC: rockchip: Add rockchip,
 codec-names property
In-Reply-To: <20170810145607.g663oq7cfxjmaxtf@sirena.org.uk>
References: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com>
 <1502340898-28403-4-git-send-email-jeffy.chen@rock-chips.com>
 <20170810145607.g663oq7cfxjmaxtf@sirena.org.uk>
Message-ID: <598D08AD.8090609@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 08/10/2017 10:56 PM, Mark Brown wrote:
> On Thu, Aug 10, 2017 at 12:54:58PM +0800, Jeffy Chen wrote:
>> Add a new rockchip,codec-names property, so that the driver can parse
>> the codecs by name.
>
> Why?  You're already referencing the CODECs by phandle and these names
> are not part of any ABI...
>

currently we are binding the phandles to a fixed codec list in the 
driver. but we want to make it dynamic, since some exist codecs could be 
optional, and some new codecs could be add for new board too.

and the support of this new property in the driver is added in 
https://patchwork.kernel.org/patch/9892737
