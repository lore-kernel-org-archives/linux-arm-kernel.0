From: arve@android.com (=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=)
Date: Tue, 15 Feb 2011 15:04:31 -0800
Subject: [PATCH 4/8] ARM: etm: Allow range selection
In-Reply-To: <20110215135054.GD18248@shisha.kicks-ass.net>
References: <1296701663-12168-1-git-send-email-arve@android.com>
	<1297750276-12475-4-git-send-email-arve@android.com>
	<20110215135054.GD18248@shisha.kicks-ass.net>
Message-ID: <AANLkTim776VyU_LioTL2-pOjskVDeU4BpFuw6CxGUXRT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 5:50 AM, Alexander Shishkin <virtuoso@slind.org> wrote:
> On Mon, Feb 14, 2011 at 10:11:12PM -0800, Arve Hj?nnev?g wrote:
>> Trace kernel text segment by default as before, allow tracing of other
>> ranges by writing a range to /sys/devices/etm/trace_range, or to trace
>> everything by writing 0 0.
>
> Since you're adding this, I think it might make sense to add a 3rd optional
> ctx id field, so that userspace tracing is also possible, especially when
> on-chip ETB sizes increase to something more sensible than what they are
> these days.
>

That might be useful, but I think it can be added later. My main
motivation for adding this is so we can turn off the filtering. We
want to use tracing in combination with a hardware watchdog to debug
hard lockups and we don't want any filtering in this case.

-- 
Arve Hj?nnev?g
