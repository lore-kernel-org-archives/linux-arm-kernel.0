From: dan.j.williams@intel.com (Dan Williams)
Date: Sat, 1 May 2010 14:01:48 -0700
Subject: [PATCH 1/7] PL330: Add common core driver\
In-Reply-To: <20100426070924.GH6684@trinity.fluff.org>
References: <1271834848-29179-1-git-send-email-jassisinghbrar@gmail.com>
	<20100426045420.GH28105@trinity.fluff.org>
	<o2m1b68c6791004252320j40360bc3x849eeeefe25fb49@mail.gmail.com>
	<20100426070924.GH6684@trinity.fluff.org>
Message-ID: <j2he9c3a7c21005011401l7935e674k7a2cf67dfe51b165@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 26, 2010 at 12:09 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Mon, Apr 26, 2010 at 03:20:59PM +0900, jassi brar wrote:
>> On Mon, Apr 26, 2010 at 1:54 PM, Ben Dooks <ben-linux@fluff.org> wrote:
>> > On Wed, Apr 21, 2010 at 04:27:28PM +0900, jassisinghbrar at gmail.com wrote:
>> >> From: Jassi Brar <jassi.brar@samsung.com>
>> >> + * Mark a _pl330_req as free.
>> >> + * We do it by writing DMAEND as the first instruction
>> >> + * because no valid request is going to have DMAEND as
>> >> + * its first instruction to execute.
>> >> + */
>> >> +#define MARK_FREE(req) ? ? ? do { \
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? _emit_END(0, (req)->mc_cpu); \
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? (req)->mc_len = 0; \
>> >> + ? ? ? ? ? ? ? ? ? ? } while (0)
>> >
>> > I think inline functions for these would be easier to read.
>> you mean alignment that we see here? it's actually correctly
>> aligned in an editor.
>
> firstly, on the grounds it avoids the whole \
> and secondly on the grounds inline functions get checked by the compiler
> whether they're used or not.

...thirdly any macro that evaluates its arguments more than once is
potentially dangerous for cases like MARK_FREE(req++).

>
> I belive any macro over a couple of lines is probably doing too much
> work.
>

--
Dan
