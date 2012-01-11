From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 11 Jan 2012 16:58:44 +0000
Subject: Clock API and "maximum rate"
In-Reply-To: <CAKGA1bmZGxxSfwGkpdyt7c-UYUTj+mV2AZhmhCUSEKTd12Q+4Q@mail.gmail.com>
References: <CAKGA1bmZGxxSfwGkpdyt7c-UYUTj+mV2AZhmhCUSEKTd12Q+4Q@mail.gmail.com>
Message-ID: <20120111165844.GL3226@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

On Wed, Jan 11, 2012 at 10:30:15AM -0600, Matt Sealey wrote:
> Just a curious question, is there any safe way in the current API or
> even by peeking a little behind the scenes to find out what the
> maximum clock rate would be for a given named clock or struct clk?

How about:

	long max = clk_round_rate(clk, ~0LU);

clk_round_rate() is one of the optional API calls though.

Jamie
