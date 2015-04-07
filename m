From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 7 Apr 2015 13:17:40 -0700
Subject: [PATCH] mm/migrate: Mark unmap_and_move() "noinline" to avoid
 ICE in gcc 4.7.3
In-Reply-To: <CAMAWPa_YEJDQc=_60_sPqzwLYN8Yefzcko_rydxrt8oOCq20gw@mail.gmail.com>
References: <20150324004537.GA24816@verge.net.au>
 <CAKv+Gu-0jPk=KQ4gY32ELc+BVbe=1QdcrwQ+Pb=RkdwO9K3Vkw@mail.gmail.com>
 <20150324161358.GA694@kahuna> <20150326003939.GA25368@verge.net.au>
 <20150326133631.GB2805@arm.com>
 <CANMBJr68dsbYvvHUzy6U4m4fEM6nq8dVHBH4kLQ=0c4QNOhLPQ@mail.gmail.com>
 <20150327002554.GA5527@verge.net.au>
 <20150327100612.GB1562@arm.com>
 <7hbnj99epe.fsf@deeprootsystems.com>
 <CAKv+Gu_ZHZFm-1eXn+r7fkEHOxqSmj+Q+Mmy7k6LK531vSfAjQ@mail.gmail.com>
 <7h8uec95t2.fsf@deeprootsystems.com>
 <alpine.DEB.2.10.1504011130030.14762@ayla.of.borg>
 <551BBEC5.7070801@arm.com>
 <20150401124007.20c440cc43a482f698f461b8@linux-foundation.org>
 <7hwq1v4iq4.fsf@deeprootsystems.com>
 <CAMAWPa_YEJDQc=_60_sPqzwLYN8Yefzcko_rydxrt8oOCq20gw@mail.gmail.com>
Message-ID: <20150407131740.ac8a856537fecb1b5d142f5f@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Apr 2015 10:57:52 -0700 Kevin Hilman <khilman@kernel.org> wrote:

> > The diff below[2] on top of yours compiles fine here and at least covers
> > the compilers I *know* to trigger the ICE.
> 
> I see my fix in your mmots since last Thurs (4/2), but it's not in
> mmotm (last updated today) so today's linux-next still has the ICE for
> anything other than gcc-4.7.3.   Just checking to see when you plan to
> update mmotm.

It should all be there today?
