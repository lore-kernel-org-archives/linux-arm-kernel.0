From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 27 Jun 2014 16:52:03 +0200
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <20140627144610.GK32514@n2100.arm.linux.org.uk>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140627130430.GH32514@n2100.arm.linux.org.uk> <53AD724D.4020704@gmail.com>
 <20140627133933.GJ23978@titan.lakedaemon.net> <53AD7544.2060701@gmail.com>
 <20140627135932.GI32514@n2100.arm.linux.org.uk> <53AD7C24.5090408@gmail.com>
 <20140627144610.GK32514@n2100.arm.linux.org.uk>
Message-ID: <53AD8513.8090009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 04:46 PM, Russell King - ARM Linux wrote:
> On Fri, Jun 27, 2014 at 04:13:56PM +0200, Sebastian Hesselbarth wrote:
>> On 06/27/2014 03:59 PM, Russell King - ARM Linux wrote:
>>> This is kind'a my point - you're confirming that you can't reliably
>>> tell which version you have by running something on the cubox itself.
>>> As Jason points out, there are those who need to choose the correct
>>> DT file when installing.
>>>
>>> So, this means that the user has to be asked.  If users have to be
>>> asked, users need some way to identify the hardware that they're
>>> running on.
>>
>> I get your point, but there is no way to automatically tell them apart.
>> IMHO, that is why cubox-dove.dts should represent the *production*
>> version.
>
> That's why I'm saying maybe there shouldn't be a distinction at DT
> level - AFAIK the GPIO-based detection also works on the production
> version.

No, it doesn't.

On Dove, mpp12 carries sdio*1* card detect.

ES has sdio*0* slot card detect routed to mpp12 and cannot rely on
SDHCI CARD_PRESENT bit. That is what the gpio workaround is for.

Production uses the correct mpp pin and cannot rely on gpio pin
value, as it is not connected to slot card detect.

So, use the wrong dts on either ES or production will break sdio card
detect.

Sebastian
