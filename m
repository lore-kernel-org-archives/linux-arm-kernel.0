From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 30 Nov 2013 15:44:40 +0000
Subject: [PATCH V2] ARM : unwinder : Prevent data abort due to stack
 overflow while executing unwind instructions Signed-off-by: Anurag
 Aggarwal <a.anurag@samsung.com>
In-Reply-To: <CAPoNrttZfHLa9WDJihChbMGNBmdtPa+TOS=HEd2Ro-3hcuVxNA@mail.gmail.com>
References: <1385717671-28953-1-git-send-email-a.anurag@samsung.com>
 <20131129125953.GG4634@e103592.cambridge.arm.com>
 <CAPoNrttZfHLa9WDJihChbMGNBmdtPa+TOS=HEd2Ro-3hcuVxNA@mail.gmail.com>
Message-ID: <20131130154440.GZ16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 08:39:02PM +0530, Anurag Aggarwal wrote:
> > You can calculate low, high and high - low once and store them in
> > unwind_ctrl_block.  No need to recalculate them every time.
> 
> I don't think it is feasible to store high and low in unwind_ctrl_block,
> we will have to recalculate them every time in this case also as the
> value of sp is which change every time and depending on the value
> of sp the value of high and low will also change.

low may change, but high definitely won't do.  The SP is not allowed to
move outside the 8K page.

Also, please learn to cut text which is not relevant to your reply,
rather than leaving lots of lines of unnecessary quoted text in.
