From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 17 Apr 2014 11:23:06 +0100
Subject: [PATCH] xen: use sync_clear_bit instead of clear_bit
In-Reply-To: <1397724110-31851-1-git-send-email-murzin.v@gmail.com>
References: <1397723881-31648-1-git-send-email-murzin.v@gmail.com>
 <1397724110-31851-1-git-send-email-murzin.v@gmail.com>
Message-ID: <534FAB8A.3090000@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/14 09:41, Vladimir Murzin wrote:
> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
> ---
>  For those who whant to play with original issue [1]
>  
>  [1] http://www.gossamer-threads.com/lists/xen/devel/325613
> 
>  drivers/xen/events/events_fifo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
> index 96109a9..91248d8 100644
> --- a/drivers/xen/events/events_fifo.c
> +++ b/drivers/xen/events/events_fifo.c
> @@ -273,7 +273,7 @@ static void consume_one_event(unsigned cpu,
>  	 * copy of the ready word.
>  	 */
>  	if (head == 0)
> -		clear_bit(priority, BM(ready));
> +		sync_clear_bit(priority, BM(ready));

I prefer the fix that makes ready an unsigned long.

David
