From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Apr 2018 09:33:14 +0100
Subject: [bug report] locking/qrwlock, arm64: Move rwlock implementation
 over to qrwlocks causes CPU crashes/stalls when killing java processes
In-Reply-To: <CACgAJHwemngF4XgfTvWkjANYoWO-=HTKrJmJg8VonJPCR8ZxrQ@mail.gmail.com>
References: <CACgAJHzeS7CNqLaVckNtS5BNTsqe0ac+u0LwJAr1_1i1=OLcnA@mail.gmail.com>
 <20180412172456.GA27033@arm.com>
 <CACgAJHz9_JKdO9bn1fiPURNq5S4XGeVNnBKx79JhM7Hcp-Tf-w@mail.gmail.com>
 <CACgAJHwemngF4XgfTvWkjANYoWO-=HTKrJmJg8VonJPCR8ZxrQ@mail.gmail.com>
Message-ID: <20180426083313.GF27583@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2018 at 08:32:24PM -0700, Tai Tri Nguyen wrote:
> I tried to remove wfe from cmpwait and still could reproduce the issue.

Hmm, then I'm afraid I'm not sure what else to suggest. You've obviously
got a lot of contention on the tasklist_lock on the exit path, but I can't
say why it's acting so slowly. If you get more information, please share
it!

Will
