From: arjan@infradead.org (Arjan van de Ven)
Date: Sun, 3 Jan 2010 15:14:06 -0800
Subject: [PATCH] stack2core: show stack message and convert it to core
	file 	when kernel die
In-Reply-To: <4B412341.2010002@kernel.org>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
	<4B411F14.1040302@kernel.org>
	<20100103150134.5bdab023@infradead.org>
	<4B412341.2010002@kernel.org>
Message-ID: <20100103151406.20228c3a@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 04 Jan 2010 08:07:45 +0900
Tejun Heo <tj@kernel.org> wrote:

> On 01/04/2010 08:01 AM, Arjan van de Ven wrote:
> > On Mon, 04 Jan 2010 07:49:56 +0900
> > Tejun Heo <tj@kernel.org> wrote:
> >>
> >> If implementing parsing of oops message in C is too awkward
> >> (unsurprising at all), maybe implementing a converter in perl or
> >> python is the easiest way so that it takes the oops message and
> >> puts out well formatted input for the s2c program?
> > 
> > you mean like scripts/markup_oops.pl ?
> 
> Whichever one works but s2c wouldn't require symbol decoding.  Maybe
> we can simply add an option to tell it to just parse the oops and
> output it in machine friendly format.  Oh, also, the patch does add
> new information the module load addresses.  We should be able to add
> those to the oops message in a compact form.

actually one does not need those; you know the start address of the
function already from the current oops output, and since you know the
address of the function within the module as well, you know the start
address of the module.


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
