From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 23 Mar 2014 19:12:05 +0100
Subject: [PATCH v2] drm/i2c: tda998x: Change the compatible strings
In-Reply-To: <20140323111903.51c73c82@armhf>
References: <20140321115541.01cbbb06@armhf> <532C40B0.3000805@gmail.com>
 <20140323111903.51c73c82@armhf>
Message-ID: <532F23F5.6020001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2014 11:19 AM, Jean-Francois Moine wrote:
> On Fri, 21 Mar 2014 14:37:52 +0100
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>>>    Required properties;
>>> -  - compatible: must be "nxp,tda998x"
>>> +  - compatible: may be "nxp,tda9989", "nxp,tda19988" or "nxp,tda19989"
>>
>> There is a "DT is ABI" policy and although there is no mainline Linux
>> user of current compatible, the correct way would be to deprecate
>> "nxp,tda998x" and introduce new compatibles.
>
> Pratically, what is this way?

Currently, there is no effective way to deprecate a binding or
compatible. You just add the one(s) that are more sensible and
you mark the old one as DEPRECATED by simply writing it in the
binding doc.

The driver should support the old binding at least for a while.

Sebastian
