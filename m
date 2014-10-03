From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 2 Oct 2014 21:35:13 -0700
Subject: [PATCH] serial/core: Initialize the console pm state
In-Reply-To: <CAMAWPa9R5HtGKkV=Ya-ekynY5maespZ0Q6BjwJcX3LN3857ZjQ@mail.gmail.com>
References: <1411367422-2095-1-git-send-email-ssreedharan@mvista.com>
 <CAMAWPa9R5HtGKkV=Ya-ekynY5maespZ0Q6BjwJcX3LN3857ZjQ@mail.gmail.com>
Message-ID: <20141003043513.GA21327@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 10:27:20AM -0700, Kevin Hilman wrote:
> On Sun, Sep 21, 2014 at 11:30 PM, Sudhir Sreedharan
> <ssreedharan@mvista.com> wrote:
> > For console devices having UART_CAP_SLEEP capability, the uart_pm_state has
> > to be initialized to UART_PM_STATE_ON. Otherwise the LCR regiser values
> > are reinitialized when uart_change_pm is called from uart_configure_port.
> >
> > Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
> 
> Multiple boot failures on ARM[1] were bisected down to this patch.
> 
> How was this patch tested, and on which platforms?
> 
> Also, the changelog states that this should be done only for
> UART_CAP_SLEEP, but the patch does it for every UART.
> 
> Greg, I suggest this patch be dropped from tty-next until it has been
> better described and tested.

Now reverted, thanks for letting me know.

greg k-h
