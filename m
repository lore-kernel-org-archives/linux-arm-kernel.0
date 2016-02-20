From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Feb 2016 22:39:15 +0100
Subject: [PATCH v2 4/4] dmaengine: pxa_dma: fix the maximum requestor line
In-Reply-To: <1455569868-25017-4-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Mon, 15 Feb 2016 21:57:48 +0100")
References: <1455569868-25017-1-git-send-email-robert.jarzmik@free.fr>
 <1455569868-25017-4-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87d1rrxdrw.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> The current number of requestor lines is limited to 31. This was an
> error of a previous commit, as this number is platform dependent, and is
> actually :
>  - for pxa25x: 40 requestor lines
>  - for pxa27x: 75 requestor lines
>  - for pxa3xx: 100 requestor lines
>
> The previous testing did not reveal the faulty constant as on pxa[23]xx
> platforms, only camera, MSL and USB are above requestor 32, and in these
> only the camera has a driver using dma.
>
> Fixes: e87ffbdf0697 ("dmaengine: pxa_dma: fix the no-requestor case")
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: change to #dma-requests the of property name
>       	  default to 32 requestors and warn as suggested by Vinod

Hi Vinod,

Are you happy with this version ?
If so could you provide me your Acked-by please ?

Cheers.

--
Robert
