From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Thu, 7 Apr 2016 11:39:58 -0700
Subject: [PATCH] ARM: dts: k2*: Rename the k2* files to keystone-k2* files
In-Reply-To: <CAGo_u6oMYZvzkvCsi8H3hvOBrPLZ-EL-T3RCA6E8BnmThrLYfA@mail.gmail.com>
References: <1458139150-30382-1-git-send-email-nm@ti.com>
 <56E97F0E.6070309@oracle.com>
 <CAGo_u6oMYZvzkvCsi8H3hvOBrPLZ-EL-T3RCA6E8BnmThrLYfA@mail.gmail.com>
Message-ID: <5706A97E.7090002@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/7/16 10:01 AM, Nishanth Menon wrote:
> Hi Santosh,
>
> On Wed, Mar 16, 2016 at 10:43 AM, santosh shilimkar
> <santosh.shilimkar@oracle.com> wrote:
>> On 3/16/2016 7:39 AM, Nishanth Menon wrote:
>>>
>>> As reported in [1], rename the k2* dts files to keystone-* files
>>> this will force consistency throughout.
>>>
>>> Script for the same (and hand modified for Makefile and MAINTAINERS
>>> files):
>>> for i in arch/arm/boot/dts/k2*
>>> do
>>>          b=`basename $i`;
>>>          git mv $i arch/arm/boot/dts/keystone-$b;
>>>          sed -i -e "s/$b/keystone-$b/g" arch/arm/boot/dts/*[si]
>>> done
>>>
>>> NOTE: bootloaders that depend on older dtb names will need to be
>>> updated as well.
>>>
>>> [1] http://marc.info/?l=linux-arm-kernel&m=145637407804754&w=2
>>>
>>> Reported-by: Olof Johansson <olof@lixom.net>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>>
>> Thanks Nishant for taking care of this. I will add this to the
>> next soon.
>>
>
> I dont see this in 4.6-rc2 yet.. did this slip our pull request? will
> be good to get this in so that we can fix up u-boot consistently.
>
As discussed already, the 4.6 merge window contained the k2g renames
as you can see from the pull request[1]. The other rename was suppose
to be for 4.7 so that it lives in next for sometime for users to get
the time to get to update the bootloaders etc.

So it didn't slip pull request but just happen to go in 4.7 pull
request. I added that to next early for testing. Hope it
clarifies.

Regards,
Santosh

[1] https://patchwork.ozlabs.org/patch/588386/
