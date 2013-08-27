From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 27 Aug 2013 15:44:41 -0600
Subject: [PATCH v2 7/9] watchdog: orion: Update device-tree binding
 documentation
In-Reply-To: <20130827083603.GA2286@localhost>
References: <1377295942-5955-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377295942-5955-8-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130826140843.GI13964@titan.lakedaemon.net>
 <20130827083603.GA2286@localhost>
Message-ID: <521D1DC9.5040409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2013 02:36 AM, Ezequiel Garcia wrote:
> On Mon, Aug 26, 2013 at 10:08:43AM -0400, Jason Cooper wrote:
>> On Fri, Aug 23, 2013 at 07:12:20PM -0300, Ezequiel Garcia wrote:
>>> Change the 'reg' property meaning, by defining two required cells.
>>> It's important to note this commit breaks DT-compatibility for this
>>> device.
>>>
>>> Cc: devicetree at vger.kernel.org
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>> ---
>>>  Documentation/devicetree/bindings/watchdog/orion-wdt.txt | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
>>> index 5dc8d30..a74c9c8 100644
>>> --- a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
>>> +++ b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
>>> @@ -3,7 +3,9 @@
>>>  Required Properties:
>>>  
>>>  - Compatibility : "marvell,orion-wdt"
>>> -- reg		: Address of the timer registers
>>> +- reg		: Two cells are required:
>>> +		  First  cell contains the global timer control register.
>>> +		  Second cell contains the watchdog counter register.

BTW, you don't have 2 cells here, but 4 cells (assuming typical
#address-cells and #size-cells values). Instead, you have 2 register
specifiers.
