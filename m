From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 3 Jun 2011 10:07:07 +0400
Subject: [PATCH 1/2] clps711x/ceiva: port to use physmap flash
In-Reply-To: <1307079069.4405.142.camel@localhost>
References: <1307015648-17505-1-git-send-email-dbaryshkov@gmail.com>
	<1307075905.4405.130.camel@localhost>
	<BANLkTi=TQfMec9Kuq4-P9Rokp44g67Tx6A@mail.gmail.com>
	<1307077842.4405.133.camel@localhost>
	<BANLkTimG86aN5hUBy=GgpMAxhiQSPbetPg@mail.gmail.com>
	<1307079069.4405.142.camel@localhost>
Message-ID: <BANLkTikDbi4YAXUy9TqOkXFDd6oVZ-Gybg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/3/11, Artem Bityutskiy <Artem.Bityutskiy@nokia.com> wrote:
> On Fri, 2011-06-03 at 09:17 +0400, Dmitry Eremin-Solenikov wrote:
>> On 6/3/11, Artem Bityutskiy <Artem.Bityutskiy@nokia.com> wrote:
>> > On Fri, 2011-06-03 at 09:02 +0400, Dmitry Eremin-Solenikov wrote:
>> >> On 6/3/11, Artem Bityutskiy <Artem.Bityutskiy@nokia.com> wrote:
>> >> > On Thu, 2011-06-02 at 15:54 +0400, Dmitry Eremin-Solenikov wrote:
>> >> >> Port ceiva machine to use physmap flash instead of custom mapping
>> >> >> driver
>> >> >> (which even can't compile cleanly with current kernels). All info
>> >> >> is gathered from drivers/mtd/maps/ceiva.c. Compile tested only.
>> >> >>
>> >> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> >> >> ---
>> >> >>  arch/arm/mach-clps711x/ceiva.c |   60
>> >> >> ++++++++++++++++++++++++++++++++++++++++
>> >> >>  1 files changed, 60 insertions(+), 0 deletions(-)
>> >> >
>> >> > Is ceiva used and not dead? May be we could kill it completely?
>> >>
>> >> No functional changes to board file since start of git history. Also
>> >> I don't know how useful can be contemporary Linux on 4 MiB of RAM
>> >
>> > I also noticed that no one is interested in this board for long time. So
>> > I suggest to remove ceiva support altogether via some arm tree.
>>
>> Anyway the patch removing mtd support can be pushed via mtd tree
>> (there is really no point on mtd/maps/ceiva.c), and removing ceiva
>> depends on Russell's decision.
>
> If you care about conflicts and how to merge all that - you can remove
> ceiva via the arm tree, and at the same time modify the driver in the
> mtd tree, and we'll just put a not to the commit message that during the
> merge this change has to be discarded. Linus did a similar thing this
> merge window for one board which mtd modified and arm tree removed.

In fact second patch from this serie (drop of drivers/mtd/maps/ceiva.c)
should be commited through the mtd tree and will bring no conflicts in
either case. And either the first patch (port of ceiva to physmap) or complete
dropout of ceiva should come through the ARM tree, again bringing
no conflicts. So with these patches we are safe :)

-- 
With best wishes
Dmitry
