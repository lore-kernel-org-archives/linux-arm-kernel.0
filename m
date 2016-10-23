From: roszenrami@gmail.com (Rami Rosen)
Date: Sun, 23 Oct 2016 15:08:56 +0300
Subject: [PATCH v4 01/10] ethernet: add sun8i-emac driver
In-Reply-To: <1475828757-926-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1475828757-926-1-git-send-email-clabbe.montjoie@gmail.com>
 <1475828757-926-2-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <CAKoUAr=HmzYHq53i1bAzgOYd8RNzO_xBi30HW41KVZ=W4-Pdvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin,


Trivial comment: rx_saf_fai and rx_daf_fail are not used. This implies that also
rx_saf_error and rx_daf_error should be removed:

> +static const char const estats_str[][ETH_GSTRING_LEN] = {
...
> +       "rx_header_error",
> +       "rx_overflow_error",
> +       "rx_saf_error",
> +       "rx_daf_error",
> +       "rx_buf_error",
...

> +
> +struct sun8i_emac_stats {
> +       u64 rx_payload_error;
...
> +       u64 rx_overflow_error;
> +       u64 rx_saf_fail;
> +       u64 rx_daf_fail;

> +       u64 tx_used_desc;
> +       u64 napi_schedule;
> +       u64 napi_underflow;
> +};
> +

Trivial: typo, should be: can transfer

> +/* The datasheet said that each descriptor can transfers up to 4096bytes
> + * But latter, a register documentation reduce that value to 2048

Regards,
Rami Rosen
