From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 8 Jul 2014 16:34:23 +0300
Subject: [PATCH 0/9] Serial ATA support for NVIDIA Tegra124
In-Reply-To: <20140708130827.GD9516@ulmo>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <5390A8F9.2090408@wwwdotorg.org> <53915F3B.6050806@nvidia.com>
 <5395FE0E.80105@wwwdotorg.org> <539601B4.1010707@kapsi.fi>
 <20140708130827.GD9516@ulmo>
Message-ID: <53BBF35F.6040809@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/14 16:08, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Mon, Jun 09, 2014 at 09:49:24PM +0300, Mikko Perttunen wrote:
>> On 06/09/2014 09:33 PM, Stephen Warren wrote:
>>> On 06/06/2014 12:27 AM, Mikko Perttunen wrote:
>>>> The only compile-time dependencies here should be that:
>>>> - patch 8 of 9 which contains the actual driver depends on patch 6 of 9
>>>> (though only when building as a module) and the efuse series
>>>
>>>> - patch 2 of 9 refers to the DT node called "padctl", so it requires the
>>>> xusb series. (in the submitted xusb series, the node isn't actually
>>>> named, though. I will fix this in v2)
>>>
>>> Isn't that dependency a run-time dependency?
>>
>> Well, the kernel will compile but the DTC step will fail if building for
>> Tegra.
>
> Since this is all changes to the DTS files, we can resolve that
> dependency in the Tegra tree by applying the XUSB padctl series
> immediately before this patch, right?

Yes.

(Also I just realized that though the fuse series is in -next, the pull 
request was NAK'd for now, so don't merge this before that is sorted out.)

>
> Thierry
>
> * Unknown Key
> * 0x7F3EB3A1
>

- Mikko
