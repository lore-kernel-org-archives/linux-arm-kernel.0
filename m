From: tiwai@suse.de (Takashi Iwai)
Date: Fri, 06 Jul 2018 16:59:23 +0200
Subject: [PATCH] sound: stm32: replace "%p" with "%pK"
In-Reply-To: <20180706130703.22352-1-benjamin.gaignard@st.com>
References: <20180706130703.22352-1-benjamin.gaignard@st.com>
Message-ID: <s5hpo00quk4.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 06 Jul 2018 15:07:03 +0200,
Benjamin Gaignard wrote:
> 
> The format specifier "%p" can leak kernel addresses.
> Use "%pK" instead.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

The code change itself is OK (apart from the subject prefix to be
"ASoC").  But do we really want to patch manually every single place
like this?  There are thousands of files using '%p'.


thanks,

Takashi
