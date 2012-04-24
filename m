From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Tue, 24 Apr 2012 10:24:37 +0200
Subject: [PATCH V2 6/9] net/stmmac: Remove conditional compilation of
 clk code
In-Reply-To: <4F964B3A.306@st.com>
References: <cover.1335246730.git.viresh.kumar@st.com>
 <4336df4e231467d253e25bbd41dbce6d189ed1e8.1335246730.git.viresh.kumar@st.com>
 <4F964551.4050507@st.com> <4F96493C.7020309@st.com> <4F964B3A.306@st.com>
Message-ID: <4F966345.5080303@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 8:42 AM, Viresh Kumar wrote:
> On 4/24/2012 12:03 PM, Giuseppe CAVALLARO wrote:
>> Oops, sorry but on a build I got:
>>
>>  CC      init/version.o
>>   LD      init/built-in.o
>>   LD      .tmp_vmlinux1
>> drivers/built-in.o: In function `stmmac_release':
>> /stlinux/cavagiu/git/mirror/net-next.git/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:1134:
>> undefined reference to `clk_disable'
>> drivers/built-in.o: In function `stmmac_open':
>> /stlinux/cavagiu/git/mirror/net-next.git/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:974:
>> undefined reference to `clk_enable'
>> /stlinux/cavagiu/git/mirror/net-next.git/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:1079:
>> undefined reference to `clk_disable'
>> drivers/built-in.o: In function `stmmac_dvr_probe':
>> /stlinux/cavagiu/git/mirror/net-next.git/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:1931:
>> undefined reference to `clk_get'
>> drivers/built-in.o: In function `stmmac_clk_csr_set':
>> /stlinux/cavagiu/git/mirror/net-next.git/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:174:
>> undefined reference to `clk_get_rate'
>> drivers/built-in.o: In function `stmmac_suspend':
>> /stlinux/cavagiu/git/mirror/net-next.git/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2030:
>> undefined reference to `clk_disable'
>> drivers/built-in.o: In function `stmmac_resume':
>> /stlinux/cavagiu/git/mirror/net-next.git/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2054:
>> undefined reference to `clk_enable'
>> make: *** [.tmp_vmlinux1] Error 1
>>
>> Pls, can you verify?
> 
> I believe, you haven't applied:
> 
> [PATCH V2 1/9] clk: Add non CONFIG_HAVE_CLK routines
> 
> which must be applied before testing this.

Yes with it applied the build is ok.

Peppe

> 
