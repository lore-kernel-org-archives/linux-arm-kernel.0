From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 09:01:49 +0000
Subject: [RFC,PATCH 1/7 v2] Add a common struct clk
In-Reply-To: <4B4C376C.6080705@st.com>
References: <1263279511.160551.332624337260.1.gpush@pororo>
	<4B4C376C.6080705@st.com>
Message-ID: <20100112090149.GB26435@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 09:48:44AM +0100, Francesco VIRLINZI wrote:
> Hi Jeremy
> In November I already sent a proposal on
>  a generic linux clk framework.
> On that I would suggest:
>
>>
>> +struct clk {
>> +	const struct clk_operations *ops;
>>    
>            spinlock_t lock;
>            const char *name;
>            int id;

Name and ID are totally pointless, unless you insist on using the clk
API in the wrong way (like S3C does.)
