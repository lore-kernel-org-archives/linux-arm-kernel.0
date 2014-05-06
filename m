From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 May 2014 13:17:15 -0300
Subject: mx6qsabresd hangs on linux-next
In-Reply-To: <5369081D.5030400@st.com>
References: <CAOMZO5DMEqs=zzNGqgKjK7wTJdiNPgEqxsX=TtqKrnpLMzpbDw@mail.gmail.com>
 <20140506141310.GA2794@dragon>
 <CAOMZO5DH5d_L-deVu=XmBo9ekq+-g704p7cyayLvp=43bnEccQ@mail.gmail.com>
 <CAOMZO5Dx0JMj3dZ7BSgaYSZZ=ZKRqQHEYWj5sb6z_9jc+cpsEw@mail.gmail.com>
 <5369081D.5030400@st.com>
Message-ID: <CAOMZO5CSp5JVy+at0H2Ory21t0ySLNGMM1WExOTkbLOt-r7mqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 6, 2014 at 1:04 PM, Maxime Coquelin <maxime.coquelin@st.com> wrote:

> i is incremented in _next_div():

Yes, I see it now.

> +static int _next_div(struct clk_divider *divider, int div)
> +{
> +       div++;
> +
> +       if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
> +               return __roundup_pow_of_two(div);
> +       if (divider->table)
> +               return _round_up_table(divider->table, div);
> +
> +       return div;
> +}
>
> Could you tell me which kind of divider it is? pow2, table, linear?

table divider.

Regards,

Fabio Estevam
