From: will.deacon@arm.com (Will Deacon)
Date: Fri, 3 Jun 2016 10:50:01 +0100
Subject: [PATCH v2 2/5] of/numa: fix a memory@ node can only contains one
 memory block
In-Reply-To: <20160603094520.GF9915@arm.com>
References: <1464427377-12712-1-git-send-email-thunder.leizhen@huawei.com>
 <1464427377-12712-3-git-send-email-thunder.leizhen@huawei.com>
 <CAL_JsqJO1jXpmAJWUhCW+OK2mpTvtwzCuy_--3sQNUQhTvyFdA@mail.gmail.com>
 <574F8DA8.4040503@huawei.com> <20160603094520.GF9915@arm.com>
Message-ID: <20160603095001.GG9915@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 10:45:20AM +0100, Will Deacon wrote:
> On Thu, Jun 02, 2016 at 09:36:40AM +0800, Leizhen (ThunderTown) wrote:
> > On 2016/6/2 4:13, Rob Herring wrote:
> > > I believe you still need this and not the one above. You only need it
> > > within the loop if you return. Otherwise, the last node always need to
> > > be put.
> > 
> > OK. Thanks.
> > 
> > Addition with Matthias's suggestion, I will move "return" into this patch,
> > so that this of_node_put(np) can be safely removed.
> 
> Do you want to include Kefeng's [1] patches in your series too? We don't
> need two sets of related NUMA cleanups :)

Actually, I see you've already respun the series, do don't worry about
doing another version just for this.

Will
