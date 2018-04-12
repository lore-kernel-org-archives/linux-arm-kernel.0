From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Apr 2018 18:24:56 +0100
Subject: [bug report] locking/qrwlock, arm64: Move rwlock implementation
 over to qrwlocks causes CPU crashes/stalls when killing java processes
In-Reply-To: <CACgAJHzeS7CNqLaVckNtS5BNTsqe0ac+u0LwJAr1_1i1=OLcnA@mail.gmail.com>
References: <CACgAJHzeS7CNqLaVckNtS5BNTsqe0ac+u0LwJAr1_1i1=OLcnA@mail.gmail.com>
Message-ID: <20180412172456.GA27033@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tai,

On Thu, Apr 12, 2018 at 10:10:40AM -0700, Tai Tri Nguyen wrote:
> Recently I have observed the CPU crashes/stalls when rebooting after I
> ran cassandra benchmark.
> The issue happens randomly.

Please could you share some logs and more details about the crashes and
stalls? At the moment there's not much we can do with this report :/

Ideally, we'd have steps to reproduce the issue, but it seems that you
don't have a reliable method for that.

One other thing you could try is removing the WFE from our cmpwait
implementation in case you have a CPU erratum in that area.

Will
