From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 1 May 2012 15:18:43 -0700
Subject: [PATCH] clk: constify parent name arrays in macros
In-Reply-To: <20120427181833.GA24587@arwen.pp.htv.fi>
References: <1335529693-14280-1-git-send-email-rnayak@ti.com>
 <CAJOA=zNzkOvzdFSuSzC015ELZWE+Jtj=H5P9fbQSHW3HZdsZow@mail.gmail.com>
 <20120427181833.GA24587@arwen.pp.htv.fi>
Message-ID: <CAJOA=zM0pwHrMM5j7c_v4Vy=r5=ChTigHDsFxTr8H_v1jNippw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 11:18 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Apr 27, 2012 at 10:55:50AM -0700, Turquette, Mike wrote:
>> On Fri, Apr 27, 2012 at 5:28 AM, Rajendra Nayak <rnayak@ti.com> wrote:
>> > parent name array is now expected to be const char *, make
>> > the relevent changes in the clk macros which define
>> > default clock types.
>> >
>> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>
>> Good catch Rajendra. ?I'll pull it into clk-next.
>>
>> Regards,
>> Mike
>>
>> > ---
>> > ?include/linux/clk-private.h | ? ?6 +++---
>> > ?1 files changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
>> > index eeae7a3..6ebec83 100644
>> > --- a/include/linux/clk-private.h
>> > +++ b/include/linux/clk-private.h
>> > @@ -70,7 +70,7 @@ struct clk {
>> > ?#define DEFINE_CLK_FIXED_RATE(_name, _flags, _rate, ? ? ? ? ? ?\
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?_fixed_rate_flags) ? ? ? ? ? ? ?\
>> > ? ? ? ?static struct clk _name; ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> > - ? ? ? static char *_name##_parent_names[] = {}; ? ? ? ? ? ? ? \
>> > + ? ? ? static const char *_name##_parent_names[] = {}; ? ? ? ? \
>
> does it make sense to have this as:
>
> static const char * const _name##_parent_names[] = { }; ??

Hi Felipe,

I don't think so.  We're never going to reference the member of the
array anyways, so I think the current approach is fine for just
satisfying type qualifier-sameness.

Thanks,
Mike
