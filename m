From: robherring2@gmail.com (Rob Herring)
Date: Tue, 08 Feb 2011 11:50:27 -0600
Subject: [PATCH 2/2] ARM: iMX5 BBG: add cpuidle driver parameters
In-Reply-To: <AANLkTiko-OjXp2SER0=fh0acSXwYDEav=kQE94UB4zY9@mail.gmail.com>
References: <1297178084-28363-1-git-send-email-yong.shen@linaro.org>	<1297178084-28363-3-git-send-email-yong.shen@linaro.org>	<87pqr2v91r.fsf@lechat.rtp-net.org>
	<AANLkTiko-OjXp2SER0=fh0acSXwYDEav=kQE94UB4zY9@mail.gmail.com>
Message-ID: <4D518263.2070503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2011 09:51 AM, Yong Shen wrote:
> Hi Arnaud,
>
> I also took a while to think about this before posting patches. I prefer
> to put it in board related code since the various PMIC used on each
> boards may have influence on cpuidle latency or other charactors,
> although it could be minor.
>

But you are not going to be doing voltage scaling in idle. Is it even 
possible to do sleeping operations like accessing a PMIC in idle?

The core is powergated, so lowering voltage would not help. Doing bus 
scaling or DDR self-refresh are the only likely additional operations.

Rob
