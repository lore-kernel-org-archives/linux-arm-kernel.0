From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 6 Sep 2016 15:40:51 +0530
Subject: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Add support for rev B1
In-Reply-To: <CAOCHtYiFjB-cuABmCiw96spc-De+qNNQYGrjp-MmNDuH2mJ9Bw@mail.gmail.com>
References: <20160902090600.27262-1-nm@ti.com>
 <20160902090600.27262-3-nm@ti.com>
 <dd74f5e1-304f-661e-7fd9-f5f81bcfc55e@ti.com>
 <CAOCHtYiFjB-cuABmCiw96spc-De+qNNQYGrjp-MmNDuH2mJ9Bw@mail.gmail.com>
Message-ID: <84be68f4-c5a6-0afe-c402-1adba9172918@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 September 2016 07:22 PM, Robert Nelson wrote:
> On Fri, Sep 2, 2016 at 5:41 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>> + Robert Nelson
>>
>> On Friday 02 September 2016 02:36 PM, Nishanth Menon wrote:
>>
>> I understand that there are existing users of A2 boards and so we simply
>> cannot remove support for those boards (at least yet).
>>
>> But given the small numbers of A2 boards, its also quite likely that we
>> will not have enough test coverage for those boards. Especially as years
>> pass and there are fewer and fewer people with access to working A2 boards.
> 
> I have a A1, A2 and a B1, that i use for testing for
> beagleboard.org...  The A1 use to be ssh-accessible for developers,
> but since moving to my new house, I haven't "yet" got that one setup
> for developers.  Right now i'm using the A2 & B1 for development of
> our default images.
> 
> Jason Kridner also has a number of boards

Availability of hardware _somewhere_ is one aspect. I am still worried
about the big difference in scale. A2 are ~200 in number where as the
production version should be in thousands.

Reuse is meant to reduce maintenance cost. In this case though, it seems
like it will do exactly the opposite - making anyone with a production
version rely on few with a non-production version to make any updates at
all.

IMHO, a common .dtsi made sense if both the boards went to production
and are largely available.

device-tree sources continue to get updates even though hardware itself
is pretty much frozen. am335x-bone-common.dtsi created 3 years back is
receiving updates still - as recently as 3 months back. So, I do expect
that A2 will need to get tested in many years to come. Not sure if it
really worth that much effort.

Thanks,
Sekhar
