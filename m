From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 17 Feb 2017 15:40:23 +0200
Subject: [PATCH 07/10] perf: Directly pass PERF_AUX_* flags to
 perf_aux_output_end
In-Reply-To: <1485540470-11469-8-git-send-email-will.deacon@arm.com>
References: <1485540470-11469-1-git-send-email-will.deacon@arm.com>
 <1485540470-11469-8-git-send-email-will.deacon@arm.com>
Message-ID: <8737fdj5q0.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> @@ -485,7 +485,8 @@ int intel_bts_interrupt(void)
>  		return handled;
>  
>  	perf_aux_output_end(&bts->handle, local_xchg(&buf->data_size, 0),
> -			    !!local_xchg(&buf->lost, 0));
> +			    local_xchg(&buf->lost, 0) ?
> +			    PERF_AUX_FLAG_OVERWRITE : 0);

Heh, this one would have taken some time to debug. :)

Regards,
--
Alex
