From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 7 Nov 2014 09:00:34 +0100
Subject: [PATCH 1/4] input: touchscreen: ti_am335x_tsc Interchange
 touchscreen and ADC steps
In-Reply-To: <545C59CD.3070707@ti.com>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
 <1414408111-2631-2-git-send-email-vigneshr@ti.com>
 <20141106141916.GA17151@netboy> <545C59CD.3070707@ti.com>
Message-ID: <20141107080033.GA6455@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 11:04:05AM +0530, Vignesh R wrote:
> 
> Currently, there is too much noise in the TSC hardware that is being
> removed by delta filtering.

The so called "filter" was only programmed because the fifo entries
were being mixed up. Sebastian fixed that.

> I tested TSC unit by removing filtering
> logic, the performance was not at all satisfactory. The cursor jumps
> wayward and smooth circles cannot be drawn. Looks like delta filtering
> cannot be removed as of now. May be I will try and address it in future.

The "filter" code is nonsensical. It picks the two values in seqeunce
that are closest to one and another. How is that supposed to work?

Did you look at the "noise"? What kind of properties did you see?

A median filter makes more sense. Or sort, remove outliers, and
average. But choosing the two closest in series is silly.

Thanks,
Richard
