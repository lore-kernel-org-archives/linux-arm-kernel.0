From: oleg@redhat.com (Oleg Nesterov)
Date: Sat, 19 Oct 2013 19:02:14 +0200
Subject: [PATCH v2 02/13] uprobes: allow ignoring of probe hits
In-Reply-To: <1381871068-27660-3-git-send-email-dave.long@linaro.org>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-3-git-send-email-dave.long@linaro.org>
Message-ID: <20131019170214.GA8324@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, David Long wrote:
>
> @@ -1732,9 +1732,6 @@ static void handle_swbp(struct pt_regs *regs)
>  		return;
>  	}
>  
> -	/* change it in advance for ->handler() and restart */
> -	instruction_pointer_set(regs, bp_vaddr);
> -

Well, this looks obviously wrong. This SET_IP() has the comment ;)

Note also that with this breaks __skip_sstep() on x86.

Oleg.
