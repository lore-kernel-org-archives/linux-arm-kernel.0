From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 17 Oct 2016 13:37:27 +0100
Subject: ARM64-cpuinfo: Combine six calls for sequence output into one
 seq_printf() call in c_show()
In-Reply-To: <a09542e6-9851-45ef-583d-338205217cfc@users.sourceforge.net>
References: <83d98772-8872-1b75-a9a5-5f08b8462e18@users.sourceforge.net>
 <20161017105605.GB29095@leverpostej>
 <a09542e6-9851-45ef-583d-338205217cfc@users.sourceforge.net>
Message-ID: <20161017123726.GE29095@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 01:30:59PM +0200, SF Markus Elfring wrote:
> >> Some data were printed into a sequence by six separate function calls.
> >> Print the same data by a single function call instead.
> > 
> > ... why?
> > 
> > Beyond simply having fewer function calls, is there an upside?
> 
> Will it matter to improve run time characteristics at this source code
> place?

I do not know. If that's not the aim of your existing patch, then I have
no idea what you're trying to achieve.

> > This makes it harder to see the relationship between the format strings
> > and their associated data, and makes the code longer.
> 
> Do you prefer an other layout for the passed data so that the increase
> of line count in my update suggestion would look differently?

I prefer the code as-is. Unless there's a compelling reason to change
it.

Thanks,
Mark.
